import React, { useEffect, useState, useRef } from "react";
import PropTypes from "prop-types";

function CategorySelect(props) {
  const isInitialMount = useRef(true);
  const [error, setError] = useState(null);
  const [categories, setCategories] = useState([]);
  const [selectedCategories, setSelectedCategories] = useState({});
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false;
    } else {
      const queryCategories = Object
        .keys(selectedCategories)
        .filter((key) => selectedCategories[key]);
      props.searchCallback(queryCategories);
    }

    return;
  }, [...selectedCategories]);
  useEffect(() => {
    fetchCategories(setCategories, setError);
    return;
  }, []);

  const changeHandler = (event, categoryID) => {
    event.preventDefault();

    setSelectedCategories((prevState) => {
      prevState[categoryID] = event.target.checked;
      return Object.assign({}, prevState);
    });
  };

  const values = categories.map((category) => {
    return (
      <label className="block" key={category.id}>
        <input
          name={category.name}
          className="mr-2"
          type="checkbox"
          checked={!!selectedCategories[category.id]}
          onChange={(event) => changeHandler(event, category.id)}
        />
        {category.name}
      </label>
    );
  });

  if (error || values.length === 0) {
    return null;
  }

  return (
    <div>{values}</div>
  );
}

function fetchCategories(setCategories, setError) {
  fetch('/api/v1/categories')
  .then(res => res.json())
  .then(
    (res) => {
      setCategories(res.categories)
    },
    (err) => {
      setError(err);
    }
  );
}

CategorySelect.propTypes = {
  searchCallback: PropTypes.func
};

export default CategorySelect;
