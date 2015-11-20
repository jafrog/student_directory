import StartApp exposing (start)
import Task
import Effects exposing (Never)
import StudentDirectory exposing (view, update, init)

app =
  start { init = init, update = update, view = view, inputs = [] }

main = app.html

port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks