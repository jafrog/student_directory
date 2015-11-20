module StudentView (student_view) where
{-|
@docs student_view
-}

import Html exposing (Html, div, button, text, span, li, img)
import Html.Attributes exposing (class, src)

import Student exposing (Student)

{-|
HTML for a student
 -}
student_view : Student -> Html
student_view student =
  li [class "student"]
       [
        span [(class "name")] [text student.name],
        span [(class "email")] [text student.email],
        span [(class "github_username")] [text student.github_username],
        img [
         (src student.photo_url),
         (class "photo")
        ] []
       ]
