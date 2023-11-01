const path = require('path');

module.exports = {
    mode: "development",
    entry: path.resolve(__dirname, './src/index.js'),
    devtool: "eval-source-map",
    module: {
        rules: [
            
          {
             test: /\.(js|jsx)$/,
             exclude: /node_modules/,
             use: ['babel-loader']
          },
          {
             test: /\.(css)$/,
             use: ['style-loader','css-loader']
          },
          { test: /\.(ts|tsx|jsx)$/, loader: "ts-loader" },
          { test: /\.txt|pdf$/, use: 'raw-loader' },
          // custom loader added by me and installed using npm i file-loader
          {
                  test: /\.(gif|svg|jpg|png)$/,  // add whatever files you wanna use within this regEx
                  use: ["file-loader"]
          }

        ]
    },
    resolve: {
        extensions: ['*', '.js', '.jsx']
    },
    output: {
        path: path.resolve(__dirname, './static/frontend'),
        filename: 'bundle.js',
    },
    devServer: {
        contentBase: path.resolve(__dirname, './static/frontend'),
        hot: true
    },
};

