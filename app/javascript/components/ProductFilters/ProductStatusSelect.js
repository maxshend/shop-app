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
    fetchStatuses();

    return;
  }, [i18n.language]);

  const fetchStatuses = () => {
    fetch(`/api/v1/products/statuses?locale=${i18n.language}`)
    .then(res => res.json())
    .then(
      (res) => {
        setStatuses(res.statuses)
      },
      (err) => {
        setError(err);
      }
    );
  };

  const changeHandler = (event) => {
    event.preventDefault();
    setStatus(event.target.value);
  };

  const values = statuses.map((status) => {
    return <option key={status.key} value={status.key}>{status.name}</option>
  });

  if (error || values.length === 0) {
    return null;
  }

  return (
    <div>
      <select id="status_select" value={status} onChange={changeHandler} className="w-full">
        {values}
      </select>
    </div>
  );
}

ProductStatusSelect.propTypes = {
  searchCallback: PropTypes.func
};

export default ProductStatusSelect;
