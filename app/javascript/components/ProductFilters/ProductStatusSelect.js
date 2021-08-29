import React, { useEffect, useState, useRef } from "react";
import PropTypes from "prop-types";
import { useTranslation } from "react-i18next";

function ProductStatusSelect(props) {
  const isInitialMount = useRef(true);
  const [status, setStatus] = useState("");
  const [error, setError] = useState(null);
  const [statuses, setStatuses] = useState([]);
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false;
    } else {
      props.searchCallback(status);
    }

    return;
  }, [status]);
  const [_, i18n] = useTranslation();
  useEffect(() => {
    fetchStatuses(setStatuses, setError, i18n.language);

    return;
  }, [i18n.language]);

  function changeHandler(event) {
    event.preventDefault();
    setStatus(event.target.value);
  }

  const values = statuses.map((status) => {
    return <option key={status.key} value={status.key}>{status.name}</option>
  });

  if (error || values.length === 0) {
    return null;
  }

  return (
    <select value={status} onChange={changeHandler}>
      {values}
    </select>
  );
}

function fetchStatuses(setStatuses, setError, language) {
  fetch(`/api/v1/products/statuses?locale=${language}`)
  .then(res => res.json())
  .then(
    (res) => {
      setStatuses(res.statuses)
    },
    (err) => {
      setError(err);
    }
  );
}

ProductStatusSelect.propTypes = {
  searchCallback: PropTypes.func
};

export default ProductStatusSelect;
