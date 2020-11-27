const fs = require("fs");
const path = require("path");

const {Products, sequelize} = require('../database/models');
const {Op} = require('sequelize');

const pathJsonProducts = path.join(__dirname , "/../data/products.JSON");

const leerJsonProducts = () => {
    let jsonProducts = fs.readFileSync(pathJsonProducts);
    return JSON.parse(jsonProducts);
};

const productsController={
           
      detalle: async (req, res)=>{
        let id = req.params.id;  
        try {
          let product = await Products.findByPk(id);
          res.render("products/productDetail", {title: "Detalle de producto", product});
        } catch (error) {
          console.log(error)
        }
        
        // let DBproducts = leerJsonProducts();
        // let product = DBproducts.find(producto => producto.id == id);
        
      },
      
      carrito:(req, res)=>{
          res.render("products/productCart", {title: "Carrito de compras"});
      },
            
      buscar: async (req, res)=>{
        let query = req.body.query;
        
        try {
          let products = await Products.findAll({
            where: { name: {[Op.like]: "%"+ query + "%"} }
          });
          res.render("products/productSearch", {title: "Productos", products, query: "RESULTADOS DE BÚSQUEDA " + query.toUpperCase()});  
        } catch (error) {
          console.log(error)
        }
        // let DBproducts = leerJsonProducts();

        
    },

    crear: (req, res)=> {
    res.render("products/productCreateForm", {title: "Crear producto nuevo"});  
    },

    processCreate:(req, res)=>{
        
        let DBproducts = leerJsonProducts();
        
        let product = {
            id: Number(DBproducts[DBproducts.length -1].id) + 1,
            ...req.body,
            images: req.files[0].filename
        }

        let nuevaDBProducts = [...DBproducts, product];

        fs.writeFileSync(pathJsonProducts, JSON.stringify(nuevaDBProducts, null, 2));

        res.redirect("/products/"+product.id);
    },
      
        

      editar:(req, res)=>{
        let id = req.params.id;  
        let DBproducts = leerJsonProducts();
        let product = DBproducts.find(producto => producto.id == id);
        // console.log(product);
        res.render("products/productEditForm", {title: "Editar producto", product: product});
      },

      processEdit:(req, res)=> {
        
        let id = req.params.id;
        let DBproducts = leerJsonProducts();
                
        let indexOldProduct = DBproducts.findIndex(producto => producto.id == id);
        
        console.log(req.files);
        let imagen;

        if(req.files == "") {
            imagen = DBproducts[indexOldProduct].images
        } else {
            imagen = req.files[0].filename
            // borrar foto vieja
        };

        

        let newProduct = {
            id: Number(req.params.id),
            ...req.body,
            images: imagen
        };

        DBproducts[indexOldProduct] = newProduct;

        fs.writeFileSync(pathJsonProducts, JSON.stringify(DBproducts, null, 2));
        
        res.redirect("/products/"+newProduct.id);

      },

      processDelete: (req, res)=> {
        
        let id = req.params.id;
        let DBproducts = leerJsonProducts();

        let nuevaDBProducts = DBproducts.filter(producto => producto.id != id);
        
        fs.writeFileSync(pathJsonProducts, JSON.stringify(nuevaDBProducts, null, 2));
        
        res.json(pathJsonProducts)
        // res.sendfile(path.resolve(__dirname + "/../data/products.JSON"));
    },

    listar: async (req,res) =>{ 
      
      try {
        let products = await Products.findAll();
        res.render("products/productSearch", {title: "Productos", products});  
      } catch (error) {
        console.log(error)
      };

    }

      
  }
  
  module.exports = productsController;
  