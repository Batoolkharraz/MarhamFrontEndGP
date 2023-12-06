
bool validateForm(formstate) {
      var formdata = formstate.currentState;
      if (formdata != null && formdata.validate()) {
        formdata.save();
        return true;
      } else {
        return false;
      }
    }