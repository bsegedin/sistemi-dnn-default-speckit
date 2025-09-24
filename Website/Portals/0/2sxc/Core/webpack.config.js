const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = (env, argv) => {
  const isProduction = argv.mode === 'production';

  return {
    mode: isProduction ? 'production' : 'development',
    entry: ['./src/scss/styles.scss' , './src/ts/scripts.ts'],
    output: {
      filename: 'scripts.js',
      path: path.resolve(__dirname, 'dist'),
      assetModuleFilename: 'images/[hash][ext][query]'
    },
    devtool: isProduction ? false : 'source-map',
    watch: !isProduction,
    stats: {
      warnings: false,
      cachedModules: false,
      groupModulesByCacheStatus: false
    },
    cache: {
      type: 'filesystem',
      cacheDirectory: path.resolve(__dirname, '.temp_cache'),
      compression: 'gzip',
    },
    resolve: {
      extensions: ['.ts', '.tsx', '.js', '.scss']
    },
    optimization: {
      minimize: isProduction,
      minimizer: [
        new TerserPlugin({
          parallel: true,
          terserOptions: {
            output: {
              comments: false,
            },
          },
        }),
        new CssMinimizerPlugin({
          minimizerOptions: {
            preset: [
              'default',
              {
                discardComments: { removeAll: true },
              },
            ],
          },
        }),
      ],
    },
    plugins: [
      new MiniCssExtractPlugin({
        filename: 'styles.css',
      }),
      new webpack.ProgressPlugin(),
    ],
    module: {
      rules: [
        {
          test: /\.tsx?$/,
          use: [
            {
              loader: 'ts-loader',
              options: {
                transpileOnly: true,
              },
            },
          ],
          exclude: /node_modules/,
        },
        {
          test: /\.s[ac]ss$/i,
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: "css-loader",
              options: {
                sourceMap: !isProduction,
                url: false,
              },
            },
            {
              loader: 'postcss-loader',
              options: {
                sourceMap: !isProduction,
                postcssOptions: {
                  plugins: function () {
                    return [
                      require('autoprefixer')
                    ];
                  }
                }
              }
            },
            {
              loader: "sass-loader",
              options: {
                sourceMap: !isProduction
              },
            }
          ],
        },
        {
          test: /\.(png|jpg)$/,
          loader: 'url-loader'
        }
      ],
    },
  };
};
