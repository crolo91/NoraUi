cd $(dirname $0)
cd ..
mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent package javadoc:javadoc sonar:sonar -Dsonar.host.url=https://sonarqube.com -Dsonar.organization=noraui -Dsonar.login=$SONAR_TOKEN -Dcucumber.options="--tags @hello,@bonjour,@blog,@playToLogoGame,@jouerAuJeuDesLogos" -PscenarioInitiator,javadoc,unit-tests -Dmaven.test.failure.ignore=true

#
# read Maven console
curl -s "https://api.travis-ci.org/jobs/${TRAVIS_JOB_ID}/log.txt?deansi=true" > nonaui.log

# check if BUILD FAILURE finded in logs
nb_failure=$(sed -n ":;s/BUILD FAILURE//p;t" nonaui.log | sed -n '$=')
if [ "$nb_failure" != "" ]; then
    echo "******** BUILD FAILURE find $nb_failure time in build"
    
    # patch for run any PR. (in PR case, the commiter do not have any sonar licence).
    sonar_governance=$(sed -n ":;s/Failed to execute goal org.sonarsource.scanner.maven:sonar-maven-plugin:3.0.1:sonar \(default-cli\) on project noraui: No license for governance//p;t" nonaui.log | sed -n '$=')
    if [ "$sonar_governance" == "" ]; then
        echo "******** BUILD FAILURE find $nb_failure time in build"
        exit 255
    fi
fi

counters=$(sed -n 's:.*<EXPECTED_RESULTS>\(.*\)</EXPECTED_RESULTS>.*:\1:p' nonaui.log | head -n 1)
nb_counters=$(sed -n ":;s/$counters//p;t" nonaui.log | sed -n '$=')
# 3 = 1 (real) + 2 counters (Excel and CSV)
if [ "$nb_counters" == "3" ]; then
    echo "******** All counter is SUCCESS"
else
    echo "******** All counter is FAIL"
    echo "$counters found $nb_counters times"
    exit 255
fi

if [ "$TRAVIS_BRANCH" = 'master' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]; then
     echo "******** Starting gpg"
     openssl aes-256-cbc -K $encrypted_a4391f72a6ef_key -iv $encrypted_a4391f72a6ef_iv -in test/codesigning.asc.enc -out test/codesigning.asc -d
     gpg --fast-import test/codesigning.asc
fi

if [ "$TRAVIS_BRANCH" = 'master' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]; then
    echo "******** Starting deploy"
    mvn clean deploy -Pdeploy --settings test/mvnsettings.xml
fi

echo ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,**/*/(##(*,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,/##//*,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,***////###/,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*/*/////(###*,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///#/////(###,,,,,,,,,,,,,,,,,,,,,,,,,,,,**/(***,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///##(/////###(,,,,,,,,,,,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(**////###/,,,,,,,,,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,*////(##(*,,,,,,,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,*////(##(*,,,,,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,**////###/,,,,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,*////(###*,,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,*////(##(,,,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,**////###(,,,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,**////###/,,,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,*////(##(*,,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,*////(##(,,,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,**///(###/,,,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,,,*////(###*,,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,,,,,*////###(,,,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,,,,,,**//*/###(,,(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,,,,,,,,**///(###/(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,,,,,,,,,,*////(######///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,,,,,,,,,,,,*////#####///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*///*(###///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///###(********************************////(#///*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*///####################################(////////*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*//////////////////////////////////////////*///*/*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,*//////////////////////////////////////////**/**/*,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,**,,,,**,,,,,,,,,,,,,,,,,,,/,,,,,*,/*,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,/(#,,,*/,,,**,,,,,,,,,,*,,,#,,,,*/,,,,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,/*,%*,*/,#/,,*#,/#,,,*,,/*,#,,,,*/,#*,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,/*,,//*/,#,,,,(*/*,,,#(*/*,#*,,,*/,#*,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,/*,,,*%/,(#,,((,/*,,*/,*#*,/%*,/#,,#*,,,,,,,,,,,,,,,,,,,,"
echo ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"

exit 0
