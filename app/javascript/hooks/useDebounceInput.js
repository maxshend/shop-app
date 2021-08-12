import { useState, useEffect } from "react";

function useDebounceInput(value, delay = 500) {
  const [debounceValue, setDebounceValue] = useState(value);
  useEffect(() => {
    const handler = setTimeout(() => setDebounceValue(value), delay);

    return () => clearTimeout(handler);
  }, [value, delay]);

  return debounceValue;
};

export default useDebounceInput;
