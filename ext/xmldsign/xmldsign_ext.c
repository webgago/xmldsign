#include <xmldsign_ext.h>

#ifndef O_BINARY
#define O_BINARY 0
#endif

int digest(char * data, byte * sum)
{
  gost_subst_block *b= &GostR3411_94_CryptoProParamSet;
  gost_hash_ctx ctx;

  init_gost_hash_ctx(&ctx, b);

  if (hash_data(&ctx, data, sum))
  {
    return 1;
  }
  else
    return 0;
}

int hash_data(gost_hash_ctx *ctx, const char *data, byte *sum)
{
  int i;
  size_t bytes = strlen(data);

  start_hash(ctx);

  if(bytes > 0)
    hash_block(ctx, data, bytes);

  finish_hash(ctx, sum);

  return 1;
}

static VALUE rb_gost_digest(VALUE self, VALUE data)
{
  byte sum[32];

  if( digest(StringValuePtr(data), sum) )
    return rb_str_new( sum, 32 );
  else
    return Qfalse;
}

/* Ruby Extension initializer */
void Init_xmldsign_ext() {
  mXmldsign     = rb_define_module("Xmldsign");
  mDigests      = rb_define_module_under(mXmldsign, "Digests");
  cGost         = rb_define_class_under(mDigests, "Gost", rb_cObject);

  rb_define_method(cGost, "binary", rb_gost_digest, 1);
}
