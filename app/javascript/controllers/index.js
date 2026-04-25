import { Application } from "@hotwired/stimulus"
import HelloController from "./hello_controller"
import AutocompleteController from "./autocomplete_controller"

const application = Application.start()

application.register("hello", HelloController)
application.register("autocomplete", AutocompleteController)