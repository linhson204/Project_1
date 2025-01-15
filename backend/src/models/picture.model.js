const mongoose = require('mongoose');
const { toJSON } = require('./plugins');

const { Schema } = mongoose;

// Define the Picture schema
const pictureSchema = new Schema({
  userId: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    index: true,
  },
  link: {
    type: String,
    required: true,
  },
  capturedAt: {
    type: Number,
    required: true,
  },
  public_id: {
    type: String,
    required: true,
  },
});

pictureSchema.plugin(toJSON);

// Create the Picture model
const Picture = mongoose.model('Picture', pictureSchema);

module.exports = Picture;
