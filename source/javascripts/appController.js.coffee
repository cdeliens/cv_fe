app = angular.module("CVApp", ["ngResource"])

app.factory "Page", ($q, $http) ->

  all: ->
    deferred = $q.defer()
    url = "http://deliens-cvbe.herokuapp.com/pages.json?callback=JSON_CALLBACK"
    $http.jsonp(url).success (json) ->
      deferred.resolve(json)
    deferred.promise

  get: (id) ->
    deferred = $q.defer()
    url = "http://deliens-cvbe.herokuapp.com/pages/#{id}.json?callback=JSON_CALLBACK"
    $http.jsonp(url).success (json) ->
      deferred.resolve(json)
    deferred.promise    

  find_by_category: (id) ->
    deferred = $q.defer()
    url = "http://deliens-cvbe.herokuapp.com/pages/find_by_category.json/?id=#{id}&callback=JSON_CALLBACK"
    $http.jsonp(url).success (json) ->
      deferred.resolve(json)
    deferred.promise      

app.factory "Post", ($q, $http) ->

  find_by_category: (id) ->
    deferred = $q.defer()
    url = "http://localhost:3000/posts/find_by_category.json/?id=#{id}&callback=JSON_CALLBACK"
    $http.jsonp(url).success (json) ->
      deferred.resolve(json)
    deferred.promise      

@AppCtrl = ($scope, Page, Post) ->


  $scope.get_contact = () ->
    Page.find_by_category('contact').then (data) ->
      $scope.posts = {}
      $scope.posts = data 
  
  $scope.get_blogs = () ->
    Post.find_by_category('blog').then (data) ->
      $scope.posts = {}
      $scope.posts = data 
      $scope.posts_menu = data
  
  $scope.get_curriculum = () ->
    Page.find_by_category('curriculum').then (data) ->
      $scope.posts = {}
      $scope.posts = data    

  $scope.get_blogs()
