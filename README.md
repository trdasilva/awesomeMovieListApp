# Awesome Movie List App

For this project, I decided to use VIPER architecture pattern, I choose it over MVP or MVVM pattern because of VIPER focus on the clean architecture concepts.
<br>Basically, we have two main modules, MovieList and MovieDetail, representing the main features of the app, each module contains the respective presenter, view, router e interactor if needed. 
On the main screen, I used the card concept to represent each movie on the list.

# Libraries

## Alamofire
One of the most known and reliable networking library for iOS. Besides, this lib is simple to use and has a large community with multiples plugins available.
All networks request within this app is made using this library

## AlamofireImage
An image loading library which supports image loading in an asynchronous way and has cache. Is a plugin for Alamofire library.
Used for load images on app list and app details screen.

## RxSwift and RxCocoa
ReactiveX implementation for Swift, an elegant way to do asynchronous operations.
Used on network operations and in the communication between Presenter and Interactor.

## RxAlamofire
Plugin for Alamofire library that provides Rx callbacks for the network operations.

## ObjectMapper
ObjectMapper is an object mapper library that makes easy to convert JSON to POJO objects.

## AlamofireObjectMapper and RxAlamofire+ObjectMapper
Plugins for Alamofire that integrates object mapper and Rx. 

