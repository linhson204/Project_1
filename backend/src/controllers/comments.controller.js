const commentService = require('../services/comments.service');
const httpStatus = require('http-status');
const ApiError = require('../utils/ApiError');
const catchAsync = require('../utils/catchAsync');

const createComment = catchAsync(async (req, res) => {
  const comment = await commentService.createComment(req.body);
  res.status(httpStatus.CREATED).send(comment);
});

const getCommentById = catchAsync(async (req, res) => {
  const comment = await commentService.getCommentById(req.params.commentId);
  if (!comment) {
    throw new ApiError(httpStatus.NOT_FOUND, 'Comment not found');
  }
  res.status(httpStatus.OK).send(comment);
});

const getCommentsByPostId = catchAsync(async (req, res) => {
  const comments = await commentService.getCommentsByPostId(req.params.postId);
  res.status(httpStatus.OK).send(comments);
});

const updateCommentById = catchAsync(async (req, res) => {
  const comment = await commentService.updateCommentById(req.params.commentId, req.body);
  res.status(httpStatus.OK).send(comment);
});

const deleteCommentById = catchAsync(async (req, res) => {
  await commentService.deleteCommentById(req.params.commentId);
  res.status(httpStatus.NO_CONTENT).send();
});

const addFeedbackToComment = catchAsync(async (req, res) => {
  const comment = await commentService.addFeedbackToComment(req.params.commentId, req.body);
  res.status(httpStatus.OK).send(comment);
});

const updateFeedbackInComment = catchAsync(async (req, res) => {
  const { commentId, feedbackId } = req.params;
  const feedbackBody = req.body;

  const updatedComment = await commentService.updateFeedbackInComment(commentId, feedbackId, feedbackBody);
  res.status(httpStatus.OK).send(updatedComment);
});

const deleteFeedbackFromComment = catchAsync(async (req, res) => {
  await commentService.deleteFeedbackFromComment(req.params.commentId, req.params.feedbackId);
  res.status(httpStatus.NO_CONTENT).send();
});

module.exports = {
  createComment,
  getCommentById,
  getCommentsByPostId,
  updateCommentById,
  deleteCommentById,
  addFeedbackToComment,
  updateFeedbackInComment,
  deleteFeedbackFromComment,
};
