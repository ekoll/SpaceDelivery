# SpaceDelivery

## About app

You can craft a spacesip and travel between stations and deliver them some spacesuits. You have limited amount of spacesuit stocks and UST(universal space time).

- Whenever you travel to another station. your UST is getting decreased.
- Also your ship has HP(health point). Your ship is damaged by time(real time, not UST).
- You can decide your stock, max UST and damage tick interval when you craft your ship.
  - Capacity decides your max stock
  - Speed decides your max UST
  - Durability decides your damage tick interval
- When your stock, UST or HP become zero, your ship returns to the home.

## Architecture

I did not use a regular naming convention at this project (For example, Not all of Interactor's has a name like XXXInteractor) and I regret a little.

Built with very bad type of MVVM. Instead of a observation strategy, there is a delegation between VM and View, and VM triggers View to update its interface.

>Don't try at home.

### Why did not you use RxSwift and RxCocoa for binding

I just did not wanted to add whole a framework that came with a programming paradigm(Reactive Programming) that is followed to solve problems like operation packaging and state transfer, to just for... binding.

### So why you did not do a basic version of Rx observables to solve binding problem

I did not have enough time to do this

### Soo Combine?

Did you look at the minimum version of this app?

>Just do not ask about KVO

## Architecture again

Project consists of 3 parts

### Domain

In here, there happens all application and business logic. All events that created by actors met by a UseCase (except increase, decrease stats at Spaceship building state. These are directly handled by `SpaceshipBlueprint`).

Core Business rules are mostly holded by entities. If there is a busines rule that is related to two model (like delivery operation), this operation is controlled by Interactor but still sub operations of this operation is managed by entities.

### Presentation

In here, there are just ViewModels. They handle user events, talk to use cases (or sometimes, entities directly), and holds holds easy consumable fields for View to be rendered.

### Main

In here there is IOS App. It contains all of the implementations that will be consumed by presentation and domain modules. Also Views are here.

## Error pronity of the components

Most of the implementation is not well built and error prone. Also they are not handled good and not presented to user as a informative way. Also some of them are not reusable. But developer may need to use them again at somewhere. (Luckyliy, this project will not be used by anyone two days after I wrote this 😀)

>Also did not test memory leaks.

## Business decisions

### UST-real time relation

I did not relate UST and real time. Because UST is already decreases with use. Also ship gets damage by real time. If i woudl relate these times, theese two logic conflict and there would be rule duplication. ship would get damage both by real time and travelling. But travelling already decreases a consumable thing (UST).

### Identifier of stations

I used name as identifier. Because API does not give me a better identifier.

### Home

In this app. Home is not "Dünya". Home is the first station come from api. If API does not return any station, home will be "Void" with zero coordinate.

### Favourites

I did not make two page for stations and favorite stations. Favorite is a filtering option in app. When I get station list from api. I traverse stations with current favorite list and mark favorite stations. Also, I update favorite stations' coordinate if needed. But I did not show favorite stations that is not in current station list, also did not delete them. So, In theory, favorite station list is a potential snowball (Luckyliy, this project will not be used by anyone two days after I wrote this 😀).

### Dark mode

There is a basic rule to follow to reach a dark mode enabled app in a basic way. Do not touch colors. I just followed this rule. And there is dark mode.

## Test

I just wrote tests for Domain module and some complex systems on Presentation module. Unfortunately I did not have enought time to handle tests and code together.

Since I haven't write well tested app before, practically I am not so good at usign test methodogies. I did not use a test methodogy, did not use a well-designed namig system for test, did not use a behavioral approach for test formats. So test files are chatic a little bit.

Test coverage of Domain is %96, but there are lots of not tested scenarios.
