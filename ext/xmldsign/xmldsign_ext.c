#include <xmldsign_ext.h>

#ifndef O_BINARY
#define O_BINARY 0
#endif

char* substring(const char* str, size_t begin, size_t len)
{
  if (str == 0 || strlen(str) == 0 || strlen(str) < begin || strlen(str) < (begin+len))
    return 0;

  return strndup(str + begin, len);
}

int digest(char * data, char * sum)
{
  gost_subst_block *b=  &GostR3411_94_CryptoProParamSet;
  gost_hash_ctx ctx;

  init_gost_hash_ctx(&ctx, b);

  if (hash_data(&ctx, data, sum))
  {
    return 1;
  }
  else
    return 0;
}

int hash_data(gost_hash_ctx *ctx, const char *data, char *sum)
{
  int i;
  size_t bytes = strlen(data);

  start_hash(ctx);

  if(bytes > 0)
    hash_block(ctx, data, bytes);

  finish_hash(ctx, sum);

  return 1;
}

static VALUE rb_gost_digest(VALUE self)
{
  char sum[32];

  VALUE data;

  data = rb_iv_get(self, "@data");

  if( digest(StringValuePtr(data), sum) )
    return rb_str_new2( substring(sum, 0, 32) );
  else
    return Qfalse;
}

/* Ruby Extension initializer */
void Init_xmldsign_ext() {
  mXmldsign     = rb_define_module("Xmldsign");
  mDigests      = rb_define_module_under(mXmldsign, "Digests");
  cGost         = rb_define_class_under(mDigests, "Gost", rb_cObject);

  rb_define_method(cGost, "binary", rb_gost_digest, 0);
}
