import React from "react";
import PropTypes from "prop-types";

class Product extends React.Component {
  render() {
    return (
      <li>{this.props.title} {this.props.id}</li>
    );
  }
}

Product.propTypes = {
  id: PropTypes.number,
  title: PropTypes.string
};

export default Product;
