class ValidationFunctions {
  // validate Title
  static String? validateTitle(String? title) {
    // check if title is not empty
    if (title == null || title.isEmpty) {
      return "No title added"; // error message
    } else {
      return null; // no error
    }
  }

  // validate Description
  static String? validateDescription(String? description) {
    // check if description is not empty
    if (description == null || description.isEmpty) {
      return "No description added"; // error message
    } else {
      return null; // no error
    }
  }
}
