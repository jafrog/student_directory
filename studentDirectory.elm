module StudentDirectory (view, update, student_directory) where
{-|
@docs view, update, student_directory
-}

import Html exposing (Html, div, button, text, span, ul)
import Html.Attributes exposing (class)
-- import Html.Events exposing (onClick)

import StudentView exposing (student_view, Student)

type Action = None
type alias StudentDirectory = {students: List Student}

{-|
Student Directory model
-}
student_directory : StudentDirectory
student_directory = {students = [{name = "Huey Duck"}, {name = "Dewey Duck"}, {name = "Louie Duck"}]}

{-|
Student Directory updates
-}
update : Action -> StudentDirectory -> StudentDirectory
update action student_directory =
  case action of
    None -> student_directory

{-|
List of students
-}
view : Signal.Address Action -> StudentDirectory -> Html
view address student_directory =
  ul [class "students"]
     (List.map student_view student_directory.students)
