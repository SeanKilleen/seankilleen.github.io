---
layout: post
title: 'Crystal Reports: Avoiding Array Size Limits Using Concatenation [Field Notes]'
date: 2012-07-18 17:00:00.000000000 -04:00
comments: true
redirect_from:
 - /2012/07/crystal-reports-avoiding-array-size.html
---
### Problem
I have a Crystal Report that needs to pass a list of items to a sub-report, so that the sub-report can find additional items without duplicating items from the master report.

Unfortunately, often times I'm dealing with a large amount of data. Crystal Reports has the following (incredibly frustrating) limitations:

* Arrays can only hold 1,000 items
* Strings can only hold 255 characters

### Solution
We're going to use an array of concatenated strings to do this.

#### Step 1: Formula to Create/Reset the array
Create a formula in crystal. I recommend using the format `array_[ArrayName]_[ArrayAction]`. In our case, this would be `array_ArrayName_CreateOrReset`.

	//Reference the shared array and the temporary string
	Shared StringVar Array array_ArrayName;
	Shared StringVar itemsList;

	//"Re-Dim" the array (clear it) and reset the string
	ReDim array_ArrayName[1];
	itemsList := "";

	//returns true since formulas cannot return arrays
	true;

#### Step 2: Formula to Increment / add to the array
Create a formula called `array_ArrayName_Increment`. This array concatenates a string until it's too big and adds it to the array once it's big enough.

In this formula, `{YourValue}` is the item that you're looping through adding to the list. **NOTE**: For some reason, I couldn't get Crystal to just end the if statement and execute the last line regardless, so I had to repeat it in an "else" statement. That's gross; let me know if you know how to get around it.

	//access shared array
	Shared StringVar Array array_ArrayName;
	Shared StringVar itemsList;

	//If the string is too big, add it to the array, reset the temporary string, and concatenate to the string
	if (length(itemsList) > 235) then
	(

		//re-dim array to increase size without losing values
		Redim preserve array_ArrayName[Ubound(array_ArrayName) + 1];

		//add the current text of the itemsList string to the array as one big chunk
		array_ArrayName[Ubound(array_ArrayName)] := itemsList;

		//clear the temporary string
		itemsList :="";

		//add your value to the string
		itemsList := itemsList + ", " + {YourValue};
	)
	else
	(

		//no addition to the array necessary; just add your value to the string
		itemsList := itemsList + ", " + {YourValue};
	)

#### Step 3: Formula to Display the Array
Here, we output all the array values (our "list of big comma-separated lists"). This formula results in some extra commas and spaces, but I don't care about that because later we'll just be looking for values within this.

The trick here is to remember that the last few items in the temporary string won't be added to the array, so we need to include them specifically.

	//reference shared array and temp item
	Shared StringVar Array array_ArrayName;
	Shared StringVar itemsList;

	//join all elements in the array together, comma-separated, plus the temporary items
	Join(array_ArrayName, " ") + itemsList;

#### Step 4: Positioning the Formulas
* Insert the `CreateOrReset` formula in the group heading (or an additional, suppressed group heading)
* Insert the increment formula in the details section (suppress if necessary)
* To test, insert the display formula in the group footer. In reality, we won't be "displaying" it in the classic sense, but rather passing it to the sub-report for futher analysis.

#### Step 5: Linking the Array to the sub-report
* Create the sub-report to display your data (outside the scope of this topic)
* Right-click on the sub-report and choose `Change Subreport Links`
* Move the array display formula into the `Field(s) to link to` box by clicking &rarr;.
* Click OK.

#### Step 6: Searching the Array items in the Sub-Report
* Open the sub-report.
* Create a formula called `AlreadyInParentReport`
* The formula should look similar to the following:

	//if you find it then it's already in the parent; otherwise it's not
	if (InStr({YourDisplayArrayParameterName}, {YourValue}) > 0) 
	then true
	else false

#### Step 7: Excluding Duplicate items from the Sub-Report
In your sub-report, In the Record selection, use the following line in addition to other constraints:

    {@AlreadyInParentReport} = false
    
#### And We're Done!
That's it. Now you should be able to do anything with those sub-report values (display them, count them, sum them, etc. etc.) and return that data to the parent report.
