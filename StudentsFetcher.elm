module StudentsFetcher (getStudents) where
{-|
Module to get a list of students from an API

@docs getStudents
-}

import Http
import Task
import Json.Decode as Json exposing ((:=), andThen)
import Effects exposing (Effects)

import Student exposing (Student)

studentsUrl : String
studentsUrl = "http://makers-directory.herokuapp.com/v1/students.json"

{-|
Get students from an API
-}
getStudents : Task.Task a (Maybe (List Student))
getStudents =
  Http.send Http.defaultSettings
      {
        url = studentsUrl,
        verb = "GET",
        body = Http.empty,
        headers = [("Access-Token", "s9ufge9s8ryh34ijkrklefjsl")]
      }
    |> Http.fromJson studentsDirectoryDecoder
    |> Task.toMaybe


studentsDirectoryDecoder : Json.Decoder (List Student)
studentsDirectoryDecoder = Json.list
                           (Json.object4
                                Student
                                ("name" := Json.string)
                                ("email" := Json.string)
                                ("github_username" := Json.string)
                                ("photo_url" := Json.string))