import React from "react"
import PropTypes from "prop-types"
import Product from './Product';

class Products extends React.Component {
  render() {
    const listProducts = JSON.parse(this.props.products).products.map(product => {
      return <Product key={product.id} id={product.id} title={product.title}/>;
    });

    return (
      <ul>{listProducts}</ul>
    );
  }
}

Products.propTypes = {
  products: PropTypes.string
};

export default Products
