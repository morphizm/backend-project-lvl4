export default (router, container) => {
  router.get('root', '/', async (ctx) => {
    console.log(container);
    await ctx.render('welcome');
  });
};
