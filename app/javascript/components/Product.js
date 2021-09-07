import React from "react";
import PropTypes from "prop-types";

function Product(props) {
  let price = <span className="font-bold">{props.price}</span>;

  if (props.old_price) {
    price = <span>
      {price}
      <span className="line-through pl-1">{props.old_price}</span>
    </span>;
  }

  return (
    <div className="product-item flex-none">
      <img src={props.poster} alt={props.title} className="w-full"/>
      <div className="flex justify-between">
        <div>{price}</div>
        <div>{props.status}</div>
      </div>
      <div className="p-1">{props.title}</div>
    </div>
  );
}

Product.propTypes = {
  id: PropTypes.number,
  title: PropTypes.string,
  poster: PropTypes.string,
  price: PropTypes.string,
  old_price: PropTypes.string,
  status: PropTypes.string
};

export default Product;
