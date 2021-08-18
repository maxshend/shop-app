import React, { useState, useEffect, useRef } from "react";
import PropTypes from "prop-types";
import { useTranslation } from "react-i18next";

import useDebounceInput from "../../hooks/useDebounceInput";

function SearchBox(props) {
  const isInitialMount = useRef(true);
  const [query, setQuery] = useState("");
  const debouncedQuery = useDebounceInput(query);
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false;
    } else {
      props.searchCallback(debouncedQuery);
    }

    return;
  }, [debouncedQuery]);
  const [t] = useTranslation();

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
        placeholder={t("search")}
      />
      <button onClick={clearQuery}>{t("clear")}</button>
    </div>
  );
}

SearchBox.propTypes = {
  searchCallback: PropTypes.func
};

export default SearchBox;
