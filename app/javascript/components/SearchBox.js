import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";

import UseDebounceInput from "../hooks/UseDebounceInput";

function SearchBox(props) {
  const [query, setQuery] = useState("");
  const debouncedQuery = UseDebounceInput(query);
  useEffect(() => {
    props.searchCallback(debouncedQuery);
  }, [debouncedQuery]);

  const changeHandler = (event) => {
    event.preventDefault();
    setQuery(event.target.value);
  };

  const clearQuery = () => setQuery("");

  return (
    <div className="flex flex-row gap-x-1">
      <input
        type="text"
        value={query}
        className="w-full border-2 border-gray p-1"
        onChange={changeHandler}
        placeholder="Search..."
      />
      <button onClick={clearQuery}>Clear</button>
    </div>
  );
};

SearchBox.propTypes = {
  searchCallback: PropTypes.func
};

export default SearchBox;
