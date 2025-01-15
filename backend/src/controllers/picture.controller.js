const httpStatus = require('http-status');
const catchAsync = require('../utils/catchAsync');
const { pictureService } = require('../services');
const ApiError = require('../utils/ApiError');

const createPicture = catchAsync(async (req, res) => {
  await pictureService.createPicture(req, res);
});

module.exports = {
  createPicture,
};
