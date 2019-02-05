./mvnw package
java -cp target/@app.name@-*.jar io.micronaut.graal.reflect.GraalClassLoadingAnalyzer target/reflect.json
native-image --no-server \
             --class-path target/@app.name@-*.jar \
             -H:ReflectionConfigurationFiles=src/main/resources/reflect.json,target/reflect.json \
             -H:EnableURLProtocols=http \
             -H:IncludeResources="logback.xml|application.yml|META-INF/services/*.*" \
             -H:Name=server \
             -H:Class=io.micronaut.function.aws.runtime.MicronautLambdaRuntime \
             -H:+ReportUnsupportedElementsAtRuntime \
             -H:-AllowVMInspection \
             -H:-UseServiceLoaderFeature \
             --allow-incomplete-classpath \
             --rerun-class-initialization-at-runtime='sun.security.jca.JCAUtil$CachedSecureRandomHolder,javax.net.ssl.SSLContext' \
             --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder,io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder,io.netty.handler.ssl.util.ThreadLocalInsecureRandom,com.sun.jndi.dns.DnsClient,io.micronaut.function.aws.proxy.MicronautLambdaContainerHandler,com.amazonaws.serverless.proxy.internal.LambdaContainerHandler,io.netty.handler.ssl.JdkNpnApplicationProtocolNegotiator,io.netty.handler.ssl.ReferenceCountedOpenSslEngine
