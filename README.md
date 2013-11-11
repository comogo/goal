[![Gem Version](https://badge.fury.io/rb/goal.png)](http://badge.fury.io/rb/goal)

Goal
====

## Examples

1) When do you want to know if you'll reach the goal for the current month.
   Assuming that my goal is 160 hours/month and we are at the 14 business day from
   the month that have 23 business days.

```ruby
calculator = Goal::HourCalculator.new

calculator.estimated_for(160) # => 97.39130434782608
```

So I need to have 97.39 hours to be within my goal.


## Using the binary file

```bash
$ goal -u freshbooks_user -t freshbooks_token

| Goals | Expected | Average |
| 160   | 97       | 4.93    |
| 200   | 121      | 9.37    |
| 250   | 152      | 14.93   |
| 300   | 182      | 20.48   |
|____________________________|
| Current time: 115.66h
| Current rate: 8.26h
| Days left:    9
```

or

```bash
$ goal -h 115.66

| Goals | Expected | Average |
| 160   | 97       | 4.93    |
| 200   | 121      | 9.37    |
| 250   | 152      | 14.93   |
| 300   | 182      | 20.48   |
|____________________________|
| Current time: 115.66h
| Current rate: 8.26h
| Days left:    9
```

or

```bash
$ goal -h 115.66 -m 120

| Goals | Expected | Average |
| 160   | 97       | 4.93    |
| 200   | 121      | 9.37    |
| 250   | 152      | 14.93   |
| 300   | 182      | 20.48   |
|____________________________|
| Current time:  115.66h
| Current money: 13.879.20
| Current rate:  8.26h
| Days left: 9
```

### Available options

```
Usage: goal [options]
    -u, --username=USERNAME          Freshbooks username
    -t, --token=TOKEN                Freshbooks token
    -g, --goals=[GOALS]              Your goal list. Ex 160:200:300
    -h, --hours=HOURS                Worked time in hours.
    -m, --money=MONEY                The money rate.
```

Options `-u` and `-t` are required and specify the user and token to access the
Freshbooks hours. But you can use the -h option to specify manually the hours.

The `-g` is optional, by default it has the following value `160:200:250:300`
