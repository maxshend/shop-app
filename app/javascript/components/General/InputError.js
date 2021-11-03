import React from "react";
import PropTypes from "prop-types";

function InputError(props) {
  if (!props.text) {
    return null;
  }

  return (
    <div className="inputError text-red-500 text-xs">
      {props.text}
    </div>
  );
}

InputError.propTypes = {
  text: PropTypes.string,
};

export default InputError;
