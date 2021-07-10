import React from "react"
import PropTypes from "prop-types"
import Product from './Product';

class Products extends React.Component {
  render() {
    const listProducts = JSON.parse(this.props.products).products.map(product => {
      return (
        <Product
          key={product.id}
          id={product.id}
          title={product.title}
          poster={product.poster}
        />
      );
    });

    return (
      <div className="bg-white flex grid grid-cols-1 content-start gap-y-3 p-2">
        {listProducts}
      </div>
    );
  }
}

Products.propTypes = {
  products: PropTypes.string
};

export default Products;
