module StudentView (student_view, Student) where
{-|
@docs student_view, Student
-}

import Html exposing (Html, div, button, text, span, li)
import Html.Attributes exposing (class)

{-|
Student model
-}
type alias Student = {
    name: String
  }
--    email: String,
--    github_username: String,
--    photo: String

{-|
HTML for a student
 -}
student_view : Student -> Html
student_view student =
  li [class "student"] [text student.name]