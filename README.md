# oystercard

Week 2 Pairing Exercise.

From: https://github.com/makersacademy/course/tree/master/oystercard  
Diode: https://diode.makersacademy.com/students/soph-g/projects/3276


### 4. Adding a balance

```
In order to use public transport  
As a customer  
I want money on my card  
```
Plan for checking a new card is initialised with a balance of 0:

```
require './lib/oystercard.rb'
card = Oystercard.new
card.balance == 0
```

In order to keep using public transport
As a customer
I want to add money to my card

require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(90)
card.balance

In order to protect my money
As a customer
I don't want to put too much money on my card

require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(900)

=> Expect raise error 'Over limit'

In order to pay for my journey
As a customer
I need my fare deducted from my card

require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(90)
card.deduct(40)
card.balance

=> Expect to see balance of 50

In order to get through the barriers
As a customer
I need to touch in and out

```shell
require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(50)

card.in_journey?
=> false

card.touch_in

card.in_journey?
=> true

card.touch_out

card.in_journey?
=> false

```

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

```ruby
require './lib/oystercard.rb'
card = Oystercard.new
card.touch_in

=> Expect an error of 'Insufficient funds'
```
TODO: Step 10
In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

_assume that a journey costs £1:_

```ruby
require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(90)
card.touch_in
card.touch_out
card.balance
=> 89

```

In order to pay for my journey
As a customer
I need to know where I've travelled from

require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(10)
card.touch_in(entry_station)
card.entry_station

=> "Victoria"

In order to know where I have been
As a customer
I want to see to all my previous trips

require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(10)
card.touch_in('entry_station')
card.touch_out('exit_station')
card.list_journeys

=> List of entry and exit

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

require './lib/oystercard.rb'
station = Station.new("Victoria",1)
station.zone

=> 1

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(10)
card.touch_in('entry_station')
card.touch_in('exit_station')
card.balance

=> Reduced by penalty amount

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated

require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(10)
card.touch_in('entry_station')
card.touch_in('exit_station')
card.balance
