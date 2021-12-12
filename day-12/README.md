# Day 12

I though that's easy. I immediately spotted the recursion. I've done path finding
and especially Dijkstra before. Instead of looking into details of Dijkstra I just 
started coding without taking some time to think. This was my problem today.
I give up today after 1.5 hours without any good progress so I just have to stop myself.

Recursion, especially debugging, is just fucking my mind.

I see that I start a node and that it has neighbours. Each neighbour is a branching event.
`start` with two neighbours produces the first two branches. 

I thought an abort condition `cave = end` plus the body of the recusion being the map on the neighbours does the trick but I somehow can't manage to build up the recursion mechanics. I always end up with my algorithm reaching the end only one time.

The problem: I have created a data structure of caves that store their state. Unfortunately I only realized after 2 hours of recursion debugging that I can't do this. I sohuld have known better. Because if `b` is visited a single time on any of the available branches it's `burned` even though there might be parallel worlds (aka branches) that might work for it. My recursion should carry around copies of the caves and not use the global.

It's too late for fixing my approach now and I have to give up.



```

```
