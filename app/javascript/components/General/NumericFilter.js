import React, { useEffect, useState, useRef } from "react";
import PropTypes from "prop-types";

import useDebounceInput from "../../hooks/useDebounceInput";

function NumericFilter(props) {
  const isInitialMount = useRef(true);
  const [value, setValue] = useState("");
  const debouncedValue = useDebounceInput(value);
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false;
    } else {
      props.searchCallback({ [props.name]: debouncedValue });
    }

    return;
  }, [debouncedValue]);

  const changeMinHandler = (event) => {
    event.preventDefault();
    setValue(event.target.value);
  };

  return (
    <div className={props.className}>
      <label className="font-bold">
        {props.label}
      </label>
      <input
        className="w-100"
        type="number"
        value={value}
        onChange={changeMinHandler}
      />
    </div>
  );
}

NumericFilter.propTypes = {
  searchCallback: PropTypes.func,
  className: PropTypes.string
};

export default NumericFilter;
