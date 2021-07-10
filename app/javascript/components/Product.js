import React from "react";
import PropTypes from "prop-types";

class Product extends React.Component {
  render() {
    return (
      <div className="product-item flex-none">
        <img src={this.props.poster} alt={this.props.title} />
        <div className="p-1">{this.props.title}</div>
      </div>
    );
  }
}

Product.propTypes = {
  id: PropTypes.number,
  title: PropTypes.string,
  poster: PropTypes.string
};

export default Product;
