module StudentDirectory where

import Html exposing (div, button, text, span, ul)
import Html.Attributes exposing (class)
-- import Html.Events exposing (onClick)

import StudentView exposing (student_view, Student)

type Action = None
type alias StudentDirectory = {students: List Student}

student_directory : StudentDirectory
student_directory = {students = [{name = "Huey Duck"}, {name = "Dewey Duck"}, {name = "Louie Duck"}]}

view student_directory =
  ul [class "students"]
     (List.map student_view student_directory.students)

main = view student_directory