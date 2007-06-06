#! /bin/sh

TEST_NAME=$1
TEST_VALIDITY=$2
TEST_TYPE1=$3
TEST_TYPE2=$4

TEST_NAME=${TEST_VALIDITY}_${TEST_NAME}
TEST_FILE=${TEST_NAME}_generated.il
echo $TEST_FILE
TEST_TYPE1=`echo $TEST_TYPE1 | sed -s 's/&/\\\&/'`
TEST_TYPE2=`echo $TEST_TYPE2 | sed -s 's/&/\\\&/'`
sed -e "s/VALIDITY/${TEST_VALIDITY}/g" -e "s/TYPE1/${TEST_TYPE1}/g" -e "s/TYPE2/${TEST_TYPE2}/g" -e "s/OPCODE/${TEST_OP}/g" > $TEST_FILE <<//EOF

// VALIDITY CIL which breaks the ECMA-335 rules. 
// this CIL should fail verification by a conforming CLI verifier.

.assembly '${TEST_NAME}_generated'
{
  .hash algorithm 0x00008004
  .ver  0:0:0:0
}

.class ClassA extends [mscorlib]System.Object
{
}

.class ClassB extends [mscorlib]System.Object
{
}

.class ClassSubA extends ClassA
{
}

.class interface abstract InterfaceA
{
}

.class interface abstract InterfaceB
{
}

.class ImplA extends [mscorlib]System.Object implements InterfaceA
{
}


.class sealed MyValueType extends [mscorlib]System.ValueType
{
	.field private int32 v
}

.class sealed MyValueType2 extends [mscorlib]System.ValueType
{
	.field private int64 v
}

.class public Template
  	extends [mscorlib]System.Object
{
    .field  public object foo
}

.class public Template\`1<T>
  	extends [mscorlib]System.Object
{
}

.class public Template\`2<T, U>
  	extends [mscorlib]System.Object
{
}

.class public Covariant\`1<+T>
  	extends [mscorlib]System.Object
{
}

.class public Contravariant\`1<-T>
  	extends [mscorlib]System.Object
{
}

.class public Bivariant\`2<+T,-U>
  	extends [mscorlib]System.Object
{
}

.class public BaseBase\`2<H,G>
  	extends [mscorlib]System.Object
{
}

.class public Base\`1<B>
  	extends class BaseBase\`2<int32, !0>
{
}

.class public SubClass1\`1<T>
  	extends class Base\`1<!0>
{
}

.class public SubClass2\`1<J>
  	extends class Base\`1<!0>
{
}

.class interface public Interface\`1<I>
{
}


.class public  InterfaceImpl\`1<M>
  	implements class Interface\`1<!0>
{
}

.class public SubCovariant\`1<K>
	extends class Covariant\`1<!0>
{
}

.class public SubContravariant\`1<H>
	extends class Contravariant\`1<!0>
{
}

.class interface public ICovariant\`1<+T>
{
}

.class interface public IContravariant\`1<-T>
{
}

.class public CovariantImpl\`1<K>
	implements class ICovariant\`1<!0>
{
}

.class public ContravariantImpl\`1<H>
	implements class IContravariant\`1<!0>
{
}


.method public static TYPE1 Main(TYPE2 V_0) cil managed
{
	.entrypoint
	.maxstack 2
	ldarg.0
	ret // VALIDITY.
}
//EOF