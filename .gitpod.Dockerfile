FROM gitpod/workspace-full

# Install Android SDK and Command Line Tools
ENV ANDROID_HOME=/opt/android-sdk
RUN mkdir -p $ANDROID_HOME/cmdline-tools \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip -d $ANDROID_HOME/cmdline-tools \
    && rm cmdline-tools.zip \
    && yes | $ANDROID_HOME/cmdline-tools/cmdline-tools/bin/sdkmanager --licenses \
    && $ANDROID_HOME/cmdline-tools/cmdline-tools/bin/sdkmanager "platform-tools" "platforms;android-31" "build-tools;31.0.0"

# Set environment variables for the Android SDK
ENV PATH=$ANDROID_HOME/platform-tools:$PATH

# Install Gradle (required for building Android projects)
RUN wget https://services.gradle.org/distributions/gradle-7.6-bin.zip -P /tmp \
    && unzip /tmp/gradle-7.6-bin.zip -d /opt \
    && rm /tmp/gradle-7.6-bin.zip

ENV GRADLE_HOME=/opt/gradle-7.6
ENV PATH=$GRADLE_HOME/bin:$PATH

# Install Java JDK (needed for Gradle and Android)
RUN sudo apt-get update && sudo apt-get install -y openjdk-11-jdk
