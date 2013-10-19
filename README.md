Goal
====

## Examples

1) When do you want to know if you'll reach the goal for the current month.
   Assuming that my goal is 160 hours/month and we are at the 14 business day from
   the month that have 23 business days.

```ruby
g = Goal.new

g.calculate_goal(160) # => 97.39130434782608
```

So I need to have 97.39 hours to be within my goal.


## Using the bin

```bash
$ goal -u freshbooks_user -t freshbooks_token

| Goals | Estimate | Avg. to Goal |
| 160   | 97       | 4.93         |
| 200   | 121      | 9.37         |
| 250   | 152      | 14.93        |
| 300   | 182      | 20.48        |
|_________________________________|
| Current:   115.66h
| Average:   8.26h
| Left days: 9
```

### Available options

```
Usage: goal [options]
    -u, --username=USERNAME          Freshbooks username
    -t, --token=TOKEN                Freshbooks token
    -g, --goals=[GOALS]              Your goal list. Ex 160:200:300
```

Options `-u` and `-t` are required and specify the user and token to access the
Freshbooks hours.

The `-g` is optional, by default it has the following value `160:200:250:300`
