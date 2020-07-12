import Sequelize, { DataTypes } from 'sequelize';
import user from './user.js';

const env = process.env.NODE_ENV || 'development';
const config = require('../../config/config.js')[env];

const db = {};

const sequelize = new Sequelize(config.database, config.username, config.password, config);

const User = user(sequelize, DataTypes);
db[User.name] = User;

Object.keys(db).forEach((modelName) => {
  // console.log(db[modelName].associate)
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
