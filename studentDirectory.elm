module StudentDirectory (view, update, init) where
{-|
@docs view, update, student_directory
-}

import Html exposing (Html, div, button, text, span, ul)
import Html.Attributes exposing (class)
import Effects exposing (Effects)
import Http
import Task
import Json.Decode as Json exposing ((:=), andThen)

import StudentView exposing (student_view, Student)

type Action = None | GotStudents (Maybe (List Student))
type alias StudentDirectory = {students: List Student}

dummy_student_list = [{name = "Huey Duck"}, {name = "Dewey Duck"}, {name = "Louie Duck"}]

{-|
Initial pair of Student Directory model and request for students
-}
init : (StudentDirectory, Effects Action)
init = ({students = []}, getStudents)

studentsUrl : String
studentsUrl = "http://makers-directory.herokuapp.com/v1/students.json"

getStudents : Effects Action
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
    |> Task.map GotStudents
    |> Effects.task

studentsDirectoryDecoder : Json.Decoder (List Student)
studentsDirectoryDecoder = Json.list (Json.object1 Student ("name" := Json.string))

{-|
Student Directory updates
-}
update : Action -> StudentDirectory -> (StudentDirectory, Effects Action)
update action student_directory =
  case action of
    None -> (student_directory, Effects.none)
    GotStudents maybeStudents ->
      (
       StudentDirectory (Maybe.withDefault student_directory.students maybeStudents),
       Effects.none)

{-|
List of students
-}
view : Signal.Address Action -> StudentDirectory -> Html
view address student_directory =
  ul [class "students"]
     (List.map student_view student_directory.students)
