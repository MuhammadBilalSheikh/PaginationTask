# Test Project

## Introduction

This project contains MVVM-Clean architecture using Combine

## Folder Structure
Every module has :

### 1- Data Layer
Repository Implementations and one or many Data Sources.

##### Repository
Repositories are responsible for coordinating data from different Data Sources.

##### Data Source
Data Source can be Remote or Local. (for example: persistent database or network call)

### 2- Domain Layer
Domain Layer (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models) & Use Cases.

##### Entity 
Entities are data models.

##### Usecases
Usecase refers to the class which contains the business logic. This does not have (compile) dependencies to the view or any external framework.

### 3- Presentation Layer
Presentation Layer contains UI (UIViewControllers). Views are coordinated by ViewModels (Presenters) which execute one or many Use Cases. Presentation Layer depends only on the Domain Layer.

##### View
ViewControllers/Views which only displays prepared data and communicate with ViewModels.

##### View Model
ViewModel receives actions from events such as button tap or view lifecycle onAppear and processes them.

### Combine 
Combine is used for mapping the data from server to viewModel

## Cloning the project

### Using XCode:

Tap the clone down arrow and choose XCode, it will then ask to choose the branch name to checkout and destination path to save. After that it will directly open the project on XCode.

### Using command:

```
git clone https://github.com/YOUR-USERNAME/REPOSITORY-TO-CLONE

```
