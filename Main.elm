import StartApp.Simple exposing (start)
import StudentDirectory exposing (view, update, student_directory)

main =
  start { model = student_directory, update = update, view = view }