---
title: "Experiments in LLM Coding: A Script to Summarize Timesheet Output"
comments: true
tags:
  - ai
  - vibe-coding
  - llm
  - tooling
date: 2025-05-18 11:46 -0500
---
I have lots of concern about AI and LLMs in general -- from the ecological to the societal. I don't believe we should be using them to manipulate or replace humans. With that said, I've been belatedly trying to explore their practical applications in my work.
One of those applications has been around generating helper scripts for some of the daily work I do, Below, I'll describe one of those journeys, which I took with .

## The Challenge

I use [Toggl](https://toggl.com) to track my time, because it's a phenomenal product that integrates itself into all the places I perform work. However, I currently have to deal with another timesheet system. Toggl is missing the exact reporting scheme which would help me out: the ability to group by date, then project, then task, and output a summary of time and also a list of all the descriptions associated with that time.
This seemed like a great possible use for an AI boost. It's a concrete task, that would save me time every day, and could be housed in a script (in my case, I chose Powershell).

## The Prompts

The exact prompts I used are below (with minor details redacted for security with `REDACTED`).

Prompt #1:

```
I'd like to write a powershell script to summaries entries from the Toggl API.
I'd like the script to take in APIKey as a parameter. This will represent the Toggl API key. I'd also like to take in the start and end date, which will be a date in YYYY-MM-DD format. If the start and end date parameters are not supplied, the script should assume one week ago in YYYY-MM-DD as the start date, and tomorrow's date in YYYY-MM-DD format as the end date.
I'd like the script to https://api.track.toggl.com/api/v9/me/time_entries?start_date=TheStartDate&end_date=TheEndDate, where TheStartDate and TheEndDate are the previously determined dates in YYYY-MM-DD format.
The API response will return an array of JSON objects that look similar to:
\    {         "id": REDACTED,         "workspace_id": REDACTED,         "project_id": null,         "task_id": null,         "billable": false,         "start": "2025-05-16T21:22:12+00:00",         "stop": "2025-05-16T21:29:49+00:00",         "duration": 457,         "description": "REDACTED",         "tags": [],         "tag_ids": [],         "duronly": true,         "at": "2025-05-16T21:29:49.815804Z",         "server_deleted_at": null,         "user_id": REDACTED,         "uid": REDACTED,         "wid": REDACTED     }
```

Prompt #2

```
I'd like the script to group the entries by the date they were entered, then the project, then the task. I'd like the script to summarize the amount of time, and concatenate the descriptions into one string, separated by a new-line.
```

Prompt #3:

```
A few adjustments

```

Prompt #4:

```
Prior to the call to get the time entries, call https://api.track.toggl.com/api/v9/me/tasks?meta=true?per_page=100&include_not_active=false. You may need to loop through these requests, using the offset provided in each response in order to generate the next request.

Use these responses to generate a list of task names for task IDs, and to lookup and use the task name in the output, rather than outputting task ID.
```

Prompt #5:

```
Prior to the call to get the time entries, also call https://api.track.toggl.com/api/v9/me/projects to retrieve a list of projects

Use this response to generate a list of project names for project IDs, and to lookup and use the project name in the output, rather than outputting project ID.
```

## The Result
Within a few minutes and only with these prompts, Claude generated the complete working Powershell script below, which accurately captures my needs and solves my problem. Definitely a "wow" moment.

```powershell
param (
    [Parameter(Mandatory=$true)]
    [string]$ApiKey,
    
    [Parameter(Mandatory=$false)]
    [string]$StartDate,
    
    [Parameter(Mandatory=$false)]
    [string]$EndDate
)

# Set default dates if not provided
if (-not $StartDate) {
    $StartDate = (Get-Date).AddDays(-7).ToString("yyyy-MM-dd")
}

if (-not $EndDate) {
    $EndDate = (Get-Date).AddDays(1).ToString("yyyy-MM-dd")
}

# Validate date format
try {
    [datetime]::ParseExact($StartDate, "yyyy-MM-dd", $null) | Out-Null
    [datetime]::ParseExact($EndDate, "yyyy-MM-dd", $null) | Out-Null
}
catch {
    Write-Error "Date format must be YYYY-MM-DD"
    exit 1
}

# Create headers with authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($ApiKey):api_token"))
$headers = @{
    Authorization = "Basic $base64AuthInfo"
}

# First, get all projects to create a mapping of project IDs to names
Write-Host "Retrieving project information..." -ForegroundColor Cyan

try {
    $projectUrl = "https://api.track.toggl.com/api/v9/me/projects"
    $projectResponse = Invoke-RestMethod -Uri $projectUrl -Headers $headers -Method Get
    
    # Create project ID to name mapping
    $projectMapping = @{}
    foreach ($project in $projectResponse) {
        $projectMapping[$project.id] = $project.name
    }
    
    Write-Host "Retrieved information for $($projectResponse.Count) projects" -ForegroundColor Cyan
}
catch {
    Write-Error "Failed to retrieve projects from Toggl API: $_"
    exit 1
}

# Then, get all tasks to create a mapping of task IDs to names
Write-Host "Retrieving task information..." -ForegroundColor Cyan

$allTasks = @()
$offset = 0
$hasMoreTasks = $true

# Paginate through all tasks
while ($hasMoreTasks) {
    $taskUrl = "https://api.track.toggl.com/api/v9/me/tasks?meta=true&per_page=100&include_not_active=false&offset=$offset"
    
    try {
        $taskResponse = Invoke-RestMethod -Uri $taskUrl -Headers $headers -Method Get
        
        # Add tasks to our collection
        $allTasks += $taskResponse
        
        # Check if we need to fetch more
        if ($taskResponse.Count -lt 100) {
            $hasMoreTasks = $false
        } else {
            $offset += 100
        }
    }
    catch {
        Write-Error "Failed to retrieve tasks from Toggl API: $_"
        exit 1
    }
}

# Create task ID to name mapping
$taskMapping = @{}
foreach ($task in $allTasks) {
    $taskMapping[$task.id] = $task.name
}

Write-Host "Retrieved information for $($allTasks.Count) tasks" -ForegroundColor Cyan
Write-Host "Fetching Toggl entries from $StartDate to $EndDate" -ForegroundColor Cyan

# Time entries API endpoint
$url = "https://api.track.toggl.com/api/v9/me/time_entries?start_date=${StartDate}&end_date=${EndDate}"

# Make API request for time entries
try {
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
    
    if ($response.Count -eq 0) {
        Write-Host "No time entries found for the specified date range." -ForegroundColor Yellow
        exit 0
    }
    
    # Process and group data by date, project, task
    $groupedEntries = @{}
    
    foreach ($entry in $response) {
        # Get the entry date (convert from ISO format to date only)
        $entryDate = [datetime]::Parse($entry.start).ToString("yyyy-MM-dd")
        
        # Get project ID and look up project name
        $projectId = $entry.project_id
        $projectName = if ($null -eq $projectId) { 
            "No Project" 
        } elseif ($projectMapping.ContainsKey($projectId)) {
            $projectMapping[$projectId]
        } else {
            "Project #$projectId"  # Fallback if project not found in mapping
        }
        
        # Get task ID and look up task name
        $taskId = $entry.task_id
        $taskName = if ($null -eq $taskId) { 
            "No Task" 
        } elseif ($taskMapping.ContainsKey($taskId)) {
            $taskMapping[$taskId]
        } else {
            "Task #$taskId"  # Fallback if task not found in mapping
        }
        
        # Get description (use empty string if null)
        $description = if ([string]::IsNullOrEmpty($entry.description)) { "(No description)" } else { $entry.description }
        
        # Calculate duration in seconds
        $duration = $entry.duration
        
        # Initialize nested structure if needed
        if (-not $groupedEntries.ContainsKey($entryDate)) {
            $groupedEntries[$entryDate] = @{}
        }
        
        if (-not $groupedEntries[$entryDate].ContainsKey($projectName)) {
            $groupedEntries[$entryDate][$projectName] = @{}
        }
        
        if (-not $groupedEntries[$entryDate][$projectName].ContainsKey($taskName)) {
            $groupedEntries[$entryDate][$projectName][$taskName] = @{
                TotalDuration = 0
                Descriptions = @()
            }
        }
        
        # Update the task entry
        $groupedEntries[$entryDate][$projectName][$taskName].TotalDuration += $duration
        $groupedEntries[$entryDate][$projectName][$taskName].Descriptions += $description
    }
    
    # Display summary
    Write-Host "`nToggl Time Entries Summary" -ForegroundColor Green
    Write-Host "-------------------------" -ForegroundColor Green
    Write-Host "Date Range: $StartDate to $EndDate" -ForegroundColor White
    Write-Host "Total Entries: $($response.Count)" -ForegroundColor White
    
    # Calculate total time across all entries
    $totalDuration = ($response | Measure-Object -Property duration -Sum).Sum
    $totalTimeSpan = [TimeSpan]::FromSeconds($totalDuration)
    $totalHoursDecimal = [math]::Round($totalTimeSpan.TotalHours, 2)
    
    Write-Host "Total Time: $totalHoursDecimal hours`n" -ForegroundColor White
    
    # Sort dates chronologically
    $sortedDates = $groupedEntries.Keys | Sort-Object
    
    # Display grouped summary
    foreach ($date in $sortedDates) {
        Write-Host "Date: $date" -ForegroundColor Cyan
        
        foreach ($projectName in $groupedEntries[$date].Keys) {
            Write-Host "  Project: $projectName" -ForegroundColor Yellow
            
            # Calculate project total time
            $projectTotalDuration = 0
            foreach ($taskName in $groupedEntries[$date][$projectName].Keys) {
                $projectTotalDuration += $groupedEntries[$date][$projectName][$taskName].TotalDuration
            }
            
            $projectTimeSpan = [TimeSpan]::FromSeconds($projectTotalDuration)
            $projectHoursDecimal = [math]::Round($projectTimeSpan.TotalHours, 2)
            
            Write-Host "    Project Total: $projectHoursDecimal hours" -ForegroundColor White
            
            foreach ($taskName in $groupedEntries[$date][$projectName].Keys) {
                Write-Host "    Task: $taskName" -ForegroundColor Magenta
                
                # Calculate task duration
                $taskDuration = $groupedEntries[$date][$projectName][$taskName].TotalDuration
                $taskTimeSpan = [TimeSpan]::FromSeconds($taskDuration)
                $taskHoursDecimal = [math]::Round($taskTimeSpan.TotalHours, 2)
                
                Write-Host "      Task Total: $taskHoursDecimal hours" -ForegroundColor White
                
                # Get only unique descriptions
                $uniqueDescriptions = $groupedEntries[$date][$projectName][$taskName].Descriptions | Select-Object -Unique
                $descriptions = $uniqueDescriptions -join "`n      "
                Write-Host "      Descriptions:`n      $descriptions" -ForegroundColor Gray
                Write-Host ""
            }
        }
        
        # Calculate daily total time
        $dailyTotalDuration = 0
        foreach ($projectName in $groupedEntries[$date].Keys) {
            foreach ($taskName in $groupedEntries[$date][$projectName].Keys) {
                $dailyTotalDuration += $groupedEntries[$date][$projectName][$taskName].TotalDuration
            }
        }
        
        $dailyTimeSpan = [TimeSpan]::FromSeconds($dailyTotalDuration)
        $dailyHoursDecimal = [math]::Round($dailyTimeSpan.TotalHours, 2)
        
        Write-Host "  Daily Total: $dailyHoursDecimal hours" -ForegroundColor Green
        Write-Host "------------------------`n" -ForegroundColor Green
    }
}
catch {
    Write-Error "Failed to retrieve data from Toggl API: $_"
    exit 1
}
```


## Reaction: Wow!

I have to say, I was pretty impressed that things could get this far in a matter of minutes and produce something that was usable without me having to write a line of code. Nice.
