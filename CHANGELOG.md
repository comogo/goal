### 0.2.0

* bug fix
  * Fix the wrong average when in beginning or end of month, issue #1

* new
  * Add a extra option -m, it is used to calculate the current money based on
    the current time.

### 0.1.0

* bug fix
  * Fix typo "Left days" => "Days left" on report
  * Now -h or -u and -t are required options for the binary file

* new
  * Removes the Base class, now there is a Calculator class reponsible to make
    the main calculations and generate data to the report
  * Add a report class to print the report
  * Add a new option -h(--hours)


### 0.0.3

* bug fix
  * Add the colorize as dependency because the bin file needs it.
