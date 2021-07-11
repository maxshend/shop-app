import React from "react";
import PropTypes from "prop-types";

class SearchBox extends React.Component {
  constructor(props) {
    super(props);

    this.changeHandler = this.changeHandler.bind(this);
    this.clearQuery = this.clearQuery.bind(this);
    this.state = { query: "" };
  }

  changeHandler(event) {
    this.setState({query: event.target.value}, () => {
      this.props.searchCallback(this.state.query);
    });

    event.preventDefault();
  }

  clearQuery() {
    this.setState({query: ''}, () => {
      this.props.searchCallback(this.state.query);
    });
  }

  render() {
    return (
      <div className="flex flex-row gap-x-1">
        <input
          type="text"
          value={this.state.query}
          className="w-full border-2 border-gray p-1"
          onChange={this.changeHandler}
          placeholder="Search..."
        />
        <button onClick={this.clearQuery}>Clear</button>
      </div>
    );
  }
}

SearchBox.propTypes = {
  searchCallback: PropTypes.func
};

export default SearchBox;
