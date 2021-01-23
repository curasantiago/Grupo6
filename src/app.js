var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var methodOverride = require('method-override');
var app = express();
var session = require('express-session')
var over18 = require('./middlewares/app/over18')
var loginVariable = require('./middlewares/app/loginVariable')

app.use(session({
  secret: 'keyboard cat',
  resave: true,
  saveUninitialized: true
}));
app.use(cookieParser());
app.use(loginVariable);


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, '../public')));

app.use(over18);


//------------rutas-----------------------//
var indexRouter = require('./routes/main');
var usersRouter = require('./routes/users');
var productsRouter = require('./routes/products');
var productsApi = require('./routes/api/productsApi');
var usersApi = require('./routes/api/usersApi');


app.use(methodOverride('_method'));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/products', productsRouter);
app.use('/api/products', productsApi);
app.use('/api/users', usersApi);

app.use('/admin', adminRouter);     


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
