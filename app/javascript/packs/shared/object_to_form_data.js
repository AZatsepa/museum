const objectToFormData = (obj, form, namespace) => {
  const fd = form || new FormData();
  let formKey;

  if (obj) {
    Object.keys(obj).forEach((property) => {
      if (Object.prototype.hasOwnProperty.call(obj, property)) {
        if (namespace) {
          formKey = `${namespace}[${property}]`;
        } else {
          formKey = property;
        }
        if (obj[property] instanceof Array) {
          obj[property].forEach((item) => {
            fd.append(`${formKey}[]`, item);
          });
        } else if (typeof obj[property] === 'object') {
          objectToFormData(obj[property], fd, formKey);
        } else {
          fd.append(formKey, obj[property]);
        }
      }
    });
  }
  return fd;
};

export default objectToFormData;
