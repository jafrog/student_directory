module StudentDirectory (view, update, init) where
{-|
@docs view, update, student_directory
-}

import Html exposing (Html, div, button, text, span, ul)
import Html.Attributes exposing (class)
import Effects exposing (Effects)
import Task

import Student exposing (Student)
import StudentView exposing (student_view)
import StudentsFetcher

type Action = None | GotStudents (Maybe (List Student))
type alias StudentDirectory = {students: List Student}

{-|
Initial pair of Student Directory model and request for students
-}
init : (StudentDirectory, Effects Action)
init = ({students = []}, callStudentsFetcher)

callStudentsFetcher : Effects Action
callStudentsFetcher =
  StudentsFetcher.getStudents |> Task.map GotStudents
                              |> Effects.task

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
