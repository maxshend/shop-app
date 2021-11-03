import React from "react";
import PropTypes from "prop-types";

function InfoMessage(props) {
  if (!props.text) {
    return null;
  }

  return (
    <div className="infoMessage w-full bg-blue-400 h-10 p-2 my-2 font-medium">
      {props.text}
    </div>
  );
}

InfoMessage.propTypes = {
  text: PropTypes.string,
};

export default InfoMessage;
