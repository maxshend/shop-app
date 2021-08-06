import React from "react";
import PropTypes from "prop-types";

function Product(props) {
  return (
    <div className="product-item flex-none">
      <img src={props.poster} alt={props.title} />
      <div className="p-1">{props.title}</div>
    </div>
  );
}

Product.propTypes = {
  id: PropTypes.number,
  title: PropTypes.string,
  poster: PropTypes.string
};

export default Product;
