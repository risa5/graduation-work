import { application } from "./application"

import AutocompleteController from "./autocomplete_controller"
import TermsController from "./terms_controller"

application.register("autocomplete", AutocompleteController)
application.register("terms", TermsController)
